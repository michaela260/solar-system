# #####################################################
# ~~~~~~~~~~~~~~~~~~~ WAVES 1 & 2 ~~~~~~~~~~~~~~~~~~~~#
# #####################################################

# require_relative "planet"
# require_relative "solar_system"

# def main

#   solar_system = SolarSystem.new('Sol')

#   mercury = Planet.new('Mercury', 'gray', 3.285e23, 5.791e7, 'A year on Mercury is 88 days long')
#   venus = Planet.new('Venus', 'yellowish', 4.867e24, 1.082e8, 'Second brightest natural object in the sky')
#   earth = Planet.new('Earth', 'blue-green', 5.972e24, 1.496e8, 'Only planet known to support life')
#   mars = Planet.new('Mars', 'red', 6.39e23, 2.279e8, 'Named after the Roman god of war')
#   jupiter = Planet.new('Jupiter', 'orange', 1.898e27, 7.785e8, 'Has 67 moons')
#   saturn = Planet.new('Saturn', 'yellow-brown', 5.683e26, 1.434e9, 'Most distant planet that can be seen with the naked eye')
#   uranus = Planet.new('Uranus', 'blue', 8.681e25, 2.871e9, 'It takes 84 earth-years for Uranus to travel around the sun')
#   neptune = Planet.new('Neptune', 'bright blue', 1.024e26, 4.495e9, 'The coldest planet in the solar system')

#   planets_list = [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune]

#   planets_list.each do |planet|
#     solar_system.add_planet(planet)
#     puts planet.summary
#   end

#   puts solar_system.list_planets

#   found_planet = solar_system.find_planet_by_name('Earth')
#   puts "\nFound: #{found_planet}"
#   puts found_planet.summary rescue nil

#   distance_difference = solar_system.distance_between('Earth', 'Mars')
#   puts "\nThe distance between Earth and Mars is #{distance_difference} km (assuming they are aligned with one another)."

# end

# main


######################################################
#~~~~~~~~~~~~~~~~~~~~ WAVE 3 ~~~~~~~~~~~~~~~~~~~~~~~~#
######################################################

require_relative "planet"
require_relative "solar_system"

# Note: I found this method online at https://mentalized.net/journal/2011/04/14/ruby-how-to-check-if-a-string-is-numeric/
# The method checks whether the value of a given string is numeric
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

def shouldnt_be_a_number_error(string_input, correct_input_type)
  until !string_input.numeric?
    print "\nError! You entered a number as the planet's #{correct_input_type}. Please enter a #{correct_input_type}: "
    string_input = gets.chomp
  end
  return string_input
end

def must_be_a_positive_number_error(string_input, correct_input_type, units)
  until string_input.numeric? && string_input.to_f > 0
    print "\nError! You entered an invalid #{correct_input_type}. Please enter the #{correct_input_type} as the number of #{units}: "
    string_input = gets.chomp
  end
  return string_input.to_f
end

def main
  
  solar_system = SolarSystem.new("Sol")
  
  mercury = Planet.new('Mercury', 'gray', 3.285e23, 5.791e7, 'A year on Mercury is 88 days long')
  venus = Planet.new('Venus', 'yellowish', 4.867e24, 1.082e8, 'Second brightest natural object in the sky')
  earth = Planet.new('Earth', 'blue-green', 5.972e24, 1.496e8, 'Only planet known to support life')
  mars = Planet.new('Mars', 'red', 6.39e23, 2.279e8, 'Named after the Roman god of war')
  jupiter = Planet.new('Jupiter', 'orange', 1.898e27, 7.785e8, 'Has 67 moons')
  saturn = Planet.new('Saturn', 'yellow-brown', 5.683e26, 1.434e9, 'Most distant planet that can be seen with the naked eye')
  uranus = Planet.new('Uranus', 'blue', 8.681e25, 2.871e9, 'It takes 84 earth-years for Uranus to travel around the sun')
  neptune = Planet.new('Neptune', 'bright blue', 1.024e26, 4.495e9, 'The coldest planet in the solar system')
  
  planets_list = [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune]
  
  planets_list.each do |planet|
    solar_system.add_planet(planet)
  end
  
  user_input = ""
  valid_inputs = ["list planets", "planet details", "add planet", "distance between", "exit"]
  
  until user_input.downcase == "exit"
    
    puts "\nPlease choose an option: \n1) List Planets \n2) Planet Details \n3) Add Planet \n4) Distance Between \n5) Exit"
    user_input = gets.chomp
    
    while !valid_inputs.include? user_input.downcase
      print "Error! Your input is invalid. Please enter either 'List Planets,' 'Planet Details,' 'Add Planet,' 'Distance Between,' or 'Exit': "
      user_input = gets.chomp
    end
    
    if user_input.downcase == "list planets"
      puts solar_system.list_planets
      
    elsif user_input.downcase == "planet details"
      print "Great! Please enter a planet name to see its details: "
      found_planet = solar_system.find_planet_by_name(gets.chomp)
      puts "\n#{found_planet}"
      puts found_planet.summary rescue nil
      
    elsif user_input.downcase == "add planet"
      puts "Awesome! Let's add a planet. Please provide details about the planet you'd like to add."
      
      planet_information_categories = ["name", "color", "mass in kg", "distance from the sun in km", "fun fact"]
      planet_information = []
      planet_information_categories.each do |category|
        print "What is this planet's #{category}? "
        planet_information << gets.chomp
      end
      
      planet_information[0] = shouldnt_be_a_number_error(planet_information[0], "name")
      planet_information[1] = shouldnt_be_a_number_error(planet_information[1], "color")
      planet_information[2] = must_be_a_positive_number_error(planet_information[2], "mass", "kg")
      planet_information[3] = must_be_a_positive_number_error(planet_information[3], "distance", "km")
      planet_information[4] = shouldnt_be_a_number_error(planet_information[4], "fun fact")
      
      added_planet = Planet.new(*planet_information)
      solar_system.add_planet(added_planet)
      
    elsif user_input.downcase == "distance between"
      puts "Okay! Let's find the distance between two planets. Please pick two planets."
      
      print "What's the first planet? "
      planet_1 = gets.chomp
      print "\nWhat's the second planet? "
      planet_2 = gets.chomp
      
      answer = solar_system.distance_between(planet_1, planet_2)
      if answer.to_s.numeric?
        puts "The distance between #{planet_1} and #{planet_2} is #{answer} km (assuming they are aligned with one another)."
      else
        puts answer
      end
      
    else
      exit
    end
    
  end
  
end

main