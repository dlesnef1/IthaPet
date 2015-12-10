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
            pet.update(hungriness: pet.hungriness-10,
                happiness: pet.happiness+5, cleanliness: pet.cleanliness-5, loyalty: pet.loyalty+5)
        elsif command == "Wash"
            pet.update(happiness: pet.happiness-5, cleanliness: pet.cleanliness+10, loyalty: pet.loyalty-5)
        elsif command == "Walk"
            pet.update(hungriness: pet.hungriness+5,
                happiness: pet.happiness+10, cleanliness: pet.cleanliness-5, loyalty: pet.loyalty+5)
        elsif command == "Pet"
            pet.update(happiness: pet.happiness+1, loyalty: pet.loyalty+1)
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

        # bugs, but will be fixed soon
        if pet.hungriness > 80
            pet.update(user: nil, hungriness: 0, cleanliness: 100, happiness: 25, loyalty: 10)
            return "PETA would like a word with you! #{pet.name} is going to a better home!"
        end
        return "nothing"
    end
end
