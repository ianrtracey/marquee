require_relative '../models/repository.rb'

class LanguageService

  def self.get_top_n_languages(n)
    all_languages = {}
    Repository.all.each do |repo|
      repo_languages = repo.languages
      if repo_languages.nil?
        next
      end
      repo_languages.each do |k, v|
        if all_languages.has_key? k
          all_languages[k] = all_languages[k] + v
        else
          all_languages[k] = v
        end
      end
    end
    if all_languages.empty?
      return []
    end
    sorted_languages = all_languages.sort_by { |_key, count| count }.reverse
    return sorted_languages[0..n]
  end

end
