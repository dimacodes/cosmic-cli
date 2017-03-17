require_relative '../bin/environment.rb'

class Apod

  attr_accessor :copyright, :date, :explanation, :hdurl, :media_type, :title, :url

  @@all = []

  def initialize(data_hash)
    data_hash.each {|k,v| self.send("#{k}=",v)}
    @@all << self
  end

  def self.most_recent
    @@all.last
  end
end
