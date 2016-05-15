
task :default => ["my_namespace:all"]
namespace :my_namespace do
  desc "TODO"
  task my_task1: :environment do
  	puts 'Pruebas realizadas'
  end


  desc "UPDATE VERSION"
  task update_version: :environment do
    @update = Update.first
    if @update != nil
      @update.version = @update.version +=1
      @update.date = Time.now
      @update.save
    else
      @update = Update.create(version: 1, date: Time.now)
    end
  end


  desc "TODO"
  task my_task2: :environment do
  	rand = Random.new(2)
  	puts rand.rand
  	if rand.rand >1
  		puts ' '
  	else
  		puts ' '
  	end
  end

task :all => ["my_namespace:my_task1", "my_namespace:my_task2"]

end

