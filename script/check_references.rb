#!/usr/bin/env ruby
# frozen_string_literal: true

# Bruk:
#   ruby script/check_references.rb                    feiler på nye referansebrudd
#   ruby script/check_references.rb --update-baseline  godtar dagens brudd som kjente
#
# Arkivet har brudd fra før. De ligger i script/known-reference-issues.txt slik at
# sjekken bare er rød for nye. Retter du en gammel, kjør --update-baseline.

require 'yaml'
require 'date'
require 'set'

ROOT = File.expand_path('..', __dir__)
BASELINE_PATH = File.join(ROOT, 'script', 'known-reference-issues.txt')
ASSOCIATIONS_DATA = File.join(ROOT, '_data', 'associations.yml')
ASSOCIATIONS_DIR = File.join(ROOT, '_associations')
POSTS_DIR = File.join(ROOT, '_posts')

ATTENDEE_KEYS = %w[attending not_attending other_attending].freeze

Finding = Struct.new(:kind, :file, :detail) do
  def key
    [kind, file, detail].join("\t")
  end

  def to_s
    format('%-14s %-58s %s', kind, file, detail)
  end
end

def relative(path)
  path.sub(%r{\A#{Regexp.escape(ROOT)}/}, '')
end

def parse_yaml(source, origin)
  YAML.safe_load(source, permitted_classes: [Date, Time], aliases: true)
rescue Psych::Exception => e
  warn "FEIL: klarte ikke lese YAML i #{origin}: #{e.message}"
  nil
end

def front_matter(path)
  source = File.read(path, mode: 'r:bom|utf-8').gsub("\r\n", "\n")
  match = source.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  return nil unless match

  parsed = parse_yaml(match[1], relative(path))
  parsed.is_a?(Hash) ? parsed : {}
rescue ArgumentError, Errno::ENOENT => e
  warn "FEIL: klarte ikke lese #{relative(path)}: #{e.message}"
  nil
end

def known_codes(registry)
  codes = Set.new
  registry.each do |key, entry|
    codes << key.to_s.downcase
    next unless entry.is_a?(Hash)

    Array(entry['former_tag']).compact.each { |tag| codes << tag.to_s.downcase }
    codes << entry['former_name'].to_s.downcase if entry['former_name']
  end
  codes
end

# Deltakerlistene er skrevet i tre konvensjoner gjennom arkivet:
#   "maki"  /  "fui, Dennis Norheim"  /  "studentavis, Hans Petter,-"
# Layouten bruker feltet før første komma som kode.
def normalize_code(raw)
  raw.to_s.split(',').first.to_s.sub(/\(.*\)/, '').strip.downcase
end

def collect_attendee_findings(known)
  findings = []
  Dir.glob(File.join(POSTS_DIR, '**', '*.md')).sort.each do |path|
    file = relative(path)
    matter = front_matter(path)

    if matter.nil?
      findings << Finding.new('front-matter', file, 'mangler eller er ugyldig front matter')
      next
    end

    ATTENDEE_KEYS.each do |key|
      Array(matter[key]).each do |raw|
        code = normalize_code(raw)
        if code.empty?
          findings << Finding.new('tom-oppforing', file, "#{key}: tomt listeelement")
        elsif !known.include?(code)
          findings << Finding.new('ukjent-kode', file, "#{key}: #{code}")
        end
      end
    end
  end
  findings
end

def collect_registry_findings(registry)
  findings = []
  stubs = Dir.glob(File.join(ASSOCIATIONS_DIR, '*.md')).map { |p| File.basename(p, '.md').downcase }.to_set

  registry.each_key do |key|
    next if stubs.include?(key.to_s.downcase)

    findings << Finding.new('mangler-stubb', '_data/associations.yml', "#{key}: ingen _associations/#{key}.md")
  end

  stubs.each do |stub|
    next if registry.key?(stub)

    findings << Finding.new('foreldrelos', "_associations/#{stub}.md", 'ingen oppføring i _data/associations.yml')
  end

  findings
end

def load_baseline
  return Set.new unless File.exist?(BASELINE_PATH)

  File.readlines(BASELINE_PATH, chomp: true)
      .reject { |line| line.strip.empty? || line.start_with?('#') }
      .to_set
end

def write_baseline(findings)
  header = "# Kjente referansebrudd, akseptert av script/check_references.rb.\n" \
           "# Regenerer med: ruby script/check_references.rb --update-baseline\n"
  File.write(BASELINE_PATH, header + findings.map(&:key).uniq.sort.join("\n") + "\n")
end

def main
  update_baseline = ARGV.include?('--update-baseline')

  registry = parse_yaml(File.read(ASSOCIATIONS_DATA), '_data/associations.yml')
  unless registry.is_a?(Hash)
    warn 'FEIL: _data/associations.yml kunne ikke leses som en mapping.'
    exit 1
  end

  findings = collect_attendee_findings(known_codes(registry)) + collect_registry_findings(registry)

  if update_baseline
    write_baseline(findings)
    puts "Skrev #{findings.map(&:key).uniq.size} kjente brudd til #{relative(BASELINE_PATH)}."
    return 0
  end

  baseline = load_baseline
  current = findings.map(&:key).to_set
  new_findings = findings.reject { |f| baseline.include?(f.key) }
  fixed = baseline - current

  puts "Sjekket #{Dir.glob(File.join(POSTS_DIR, '**', '*.md')).size} referater og #{registry.size} foreninger."
  puts "#{findings.size} brudd totalt, #{baseline.size} kjent fra før."

  unless fixed.empty?
    puts
    puts "#{fixed.size} brudd i baselinen er rettet. Kjør --update-baseline for å fjerne dem."
  end

  if new_findings.empty?
    puts
    puts 'Ingen nye referansebrudd.'
    return 0
  end

  puts
  puts "#{new_findings.size} nye referansebrudd:"
  new_findings.each { |f| puts "  #{f}" }
  puts
  puts 'Rett dem, eller legg til koden i former_tag i _data/associations.yml.'
  1
end

exit(main) if $PROGRAM_NAME == __FILE__
