# Простейший Спутник-1

## Using

You can get the most recent stable version through RubyGems.

Install via Bundler/Gemfile

    gem "mongohq", "~> 0.5.0"

Install gem through command line

    gem install mongohq

To use it, just require rubygems (or not, if you used Bundler) and mongohq, then do stuff.

    require 'rubygems'
    require 'mongohq'

    # Must first authenticate using your account's API key
    MongoHQ.authenticate(:apikey => 'derp')

	# Get all databases
    databases = MongoHQ::Database.all

    # Get a single database
    database =  MongoHQ::Database.find('foods')

    # Get a single database stats (two ways)
    database.stats == MongoHQ::DatabaseStats.find('foods')

    # Get a single database's collections (two ways)
    collection = database.collections.find('main_courses')
    collection = MongoHQ::Collection.find('foods', 'main_courses')

    # Get a single collection's documents (two ways)
    document = collection.documents.find('pierogi')
    document = MongoHQ::Document.find('foods', 'main_courses', 'pierogi')

    # Get a single collection's indices (two ways)
    index = collection.indexes.find('_id_')
    index = MongoHQ::Index.find('foods', 'main_courses', '_id_')

    # Create a database (or Collection, or Document, or Index)
    MongoHQ::Database.create({db: 'derp'})

    # Update a Document (or collection)
    MongoHQ::Document.update('foods', 'main_courses', 'pierogi', {'$set' => {'method' => 'boiled'}})
    document.update({'$set' => {'method' => 'boiled'}})

    # Delete a database (or Collection, or Document, or Index)
    MongoHQ::Database.delete('derp')

