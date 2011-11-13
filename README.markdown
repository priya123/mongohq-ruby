# Простейший Спутник-1

![Спутник](http://www.uwgb.edu/dutchs/Graphics-Geol/Spacecraft/sputnik1.gif)

## Using

Sputnik.authenticate(:apikey => 'derp', :base_url => 'http://localhost:9000')

    databases = Sputnik::Database.all
    database =  Sputnik::Database.find('joemo')
    database.collection.all
    Sputnik::Database.create({db: 'derp'})
    Sputnik::Database.delete('derp')
