# Простейший Спутник-1

![Спутник](http://www.uwgb.edu/dutchs/Graphics-Geol/Spacecraft/sputnik1.gif)

## Using

You can get the most recent stable version through RubyGems.

Install via Bundler/Gemfile

    gem "sputnick", "~> 0.1"

Install gem through command line

    gem install sputnick

To use it, just require rubygems (or not, if you used Bundler) and sputnick, then do stuff.

    require 'rubygems'
    require 'sputnick'

    # Must first authenticate using your account's API key
    Sputnik.authenticate(:apikey => 'derp')

	# Get all databases
    databases = Sputnik::Database.all

    # Get a single database
    database =  Sputnik::Database.find('foods')

    # Get a single database stats (two ways)
    database.stats == Sputnik::DatabaseStats.find('foods')

    # Get a single database's collections (two ways)
    collection = database.collections.find('main_courses')
    collection = Sputnik::Collection.find('foods', 'main_courses')

    # Get a single collection's documents (two ways)
    document = collection.documents.find('pierogi')
    document = Sputnik::Document.find('foods', 'main_courses', 'pierogi')

    # Get a single collection's indices (two ways)
    index = collection.indexes.find('_id_')
    index = Sputnik::Index.find('foods', 'main_courses', '_id_')

    # Create a database (or Collection, or Document, or Index)
    Sputnik::Database.create({db: 'derp'})

    # Update a Document (or collection)
    Sputnik::Document.update('foods', 'main_courses', 'pierogi', {'$set' => {'method' => 'boiled'}})
    document.update({'$set' => {'method' => 'boiled'}})

    # Delete a database (or Collection, or Document, or Index)
    Sputnik::Database.delete('derp')

