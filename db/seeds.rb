# coding: utf-8

require "csv"

CSV.foreach('db/trainees.csv') do |row|
  Trainee.create(:enable => row[0], :grade => row[1], :name => row[2], :nickname => row[3], :branch => row[4], :email => row[5], :password => row[6])
end

CSV.foreach('db/trainers.csv') do |row|
  Trainer.create(:enable => row[0], :grade => row[1], :name => row[2], :nickname => row[3], :branch => row[4], :email => row[5], :password => row[6])
end



#CSV.foreach('db/checklists.csv') do |row|
#  Checklist.create(:admin_id => '1', :enable => row[0], :category => row[1], :chapter => row[2], :section => row[3], :content => row[4], :pg1ac => row[5], :pg1ak => row[6], :pg1bc => row[7], :pg1bk => row[8], :pg2ac => row[9], :pg2ak => row[10], :pg2bc => row[11], :pg2bk => row[12], :pg2cc => row[13], :pg2ck => row[14], :pg3a => row[15], :pg3b => row[16], :pg3c => row[17], :g1a => row[18], :g1b => row[19], :g1c => row[20], :g1d => row[21], :g2a => row[22], :g2b => row[23], :g2c => row[24], :g2d => row[25],)
#end