require_relative '../models/Repository'
require_relative '../models/Meta'

class ActivityService
  def self.get_activity
    result = {:num_commits => 0, :lines_code => 0, :num_repos => 0}
    num_commits = 0
    lines_code = 0
    Repository.all.each do |repo|
      if repo.commit_stat.nil?
        lines_code += 0
        num_commits += 0
      else
        lines_code += repo.commit_stat.total_lines
        num_commits += repo.commit_stat.num_commits
      end
    end
    result[:num_repos] = Repository.count
    result[:lines_code] = lines_code
    result[:num_commits] = num_commits
    result
  end

  def self.get_recent_n_commiters(n)
    Repository.where(:commit_stat.ne => nil).order_by("commit_stat.updated_at" => :desc).limit(n).to_a
  end

  def self.get_commiter_updates
    meta = Meta.instance
    if meta.last_recent_commiter_query.nil?
      meta.last_recent_commiter_query = Time.now
      meta.save
      return self.get_recent_n_commiters(10)
    end
    result = Repository.where("commit_stat.updated_at" => { '$gte' => meta.last_recent_commiter_query } ).to_a
    meta.last_recent_commiter_query = Time.now
    meta.save
    return result
  end
end
