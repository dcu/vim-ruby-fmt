# Thing
class AutocorrectFormatter < Rubocop::Formatter::BaseFormatter
  def file_finished(file, offenses)
    cops ||= begin
        Rubocop::Cop::Cop.all.each_with_object([]) do |cop_class, instances|
        instances << cop_class.new(nil, {auto_correct: true})
      end
    end
    processed_source = Rubocop::SourceParser.parse_file(file)
    errors = []
    cops.each do |cop|
      next unless cop.respond_to?(:investigate)

      if cop.respond_to?(:relevant_file?)
        # ignore files that are of no interest to the cop in question
        filename = processed_source.buffer.name
        next unless cop.relevant_file?(filename)
      end

      begin
        cop.investigate(processed_source)
      rescue => e
        errors << e
      end
    end

    corrections = cops.reduce([]) do |array, cop|
      array.concat(cop.corrections)
      array
    end
    corrector = Rubocop::Cop::Corrector.new(processed_source.buffer, corrections)
    puts corrector.rewrite
  end
end
