require_relative '../models/Repository'

class ActivityService
  def self.get_activity
    result = {:num_commits => 0, :lines_code => 0, :num_repos => 0}
    num_commits = 0
    lines_code = 0
    Repository.all.each do |repo|
      lines_code += repo.commit_stat.total_lines
      num_commits += repo.commit_stat.num_commits
    end
    result[:num_repos] = Repository.count
    result[:lines_code] = lines_code
    result[:num_commits] = num_commits
    result
  end
end
