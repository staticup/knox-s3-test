walk = require 'walk'
knox = require 'knox'

knoxClient = knox.createClient
  key: process.env.AWS_KEY
  secret: process.env.AWS_SECRET
  bucket: process.env.AWS_BUCKET

putThisFile = (file, prefix) ->
  knoxClient.putFile prefix + '/' + file, '/' + prefix + '/' + file, (err, res) ->
    if err
      console.log err
    else
      console.log res.statusCode
      console.log res.headers
      res.resume()

walker = walk.walk process.env.FOLDER

walker.on 'file', (root, fileStats, next) ->
  console.log root + '/' + fileStats.name
  putThisFile fileStats.name, root
  next()

walker.on 'end', ->
  console.log 'done'


###
walker.on 'names', (root, nodeNamesArray) ->
  console.log nodeNamesArray

walker.on 'directories', (root, dirStatsArray, next) ->
  console.log dirStatsArray
  next()

walker.on 'errors', (root, nodeStatsArray, next) ->
  console.log nodeStatsArray
  next()


knoxClient.list (err, data) ->
  console.log err if err
  console.log data
###

