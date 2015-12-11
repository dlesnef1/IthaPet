module PetsHelper
    def howHappy(pet)
        if pet.happiness > 75
            "http://emojipedia-us.s3.amazonaws.com/cache/9f/7d/9f7df7b8aaad4ac1e897259a29995f3a.png"
        elsif pet.happiness > 25
            "http://emojipedia-us.s3.amazonaws.com/cache/45/99/4599951f963380afc847d357adc68ace.png"
        else
            "http://emojipedia-us.s3.amazonaws.com/cache/6d/5a/6d5a25b6b679412b8211a9f717d81366.png"
        end
    end

    def interact(pet, command)
        if command == "Feed"
            pet.update(hungriness: pet.hungriness-rand(10..25),
                happiness: pet.happiness+rand(5..9), cleanliness: pet.cleanliness-rand(2..6), loyalty: pet.loyalty+rand(5..12))
        elsif command == "Wash"
            pet.update(happiness: pet.happiness-rand(10..13),
                cleanliness: pet.cleanliness+rand(12..19), loyalty: pet.loyalty-rand(0..5))
        elsif command == "Walk"
            pet.update(hungriness: pet.hungriness+rand(2..6),
                happiness: pet.happiness+rand(14..21), cleanliness: pet.cleanliness-rand(4..8), loyalty: pet.loyalty+rand(5..15))
        elsif command == "Pet"
            pet.update(happiness: pet.happiness+1, loyalty: pet.loyalty+1)
        elsif command == "Timer"
            pet.update(hungriness: pet.hungriness+rand(12..19),
                happiness: pet.happiness-rand(5..12), cleanliness: pet.cleanliness-rand(0..3), loyalty: pet.loyalty-rand(0..2))
        end
        checkSums(pet)
    end

    def checkSums(pet)
        attributes = [:hungriness, :happiness, :loyalty, :cleanliness]
        attributes.each do |attribute|
            if pet[attribute] > 100
                pet[attribute] = 100
            elsif pet[attribute] < 0
                pet[attribute] = 0
            end
        end
        pet.save

        if pet.hungriness > 80
            pet.update(user: nil, hungriness: 0, cleanliness: 100, happiness: 25, loyalty: 10)
            return "PETA would like a word with you! #{pet.name} is going to a better home!"
        end
        return "nothing"
    end
end
