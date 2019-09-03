const mongoose = require('mongoose')


require('./Usuario')
require('./Empresa')
require('./Avaliacao')

const options = {
  autoIndex: false, // Don't build indexes
  reconnectTries: Number.MAX_VALUE, // Never stop trying to reconnect
  reconnectInterval: 500, // Reconnect every 500ms
  poolSize: 10, // Maintain up to 10 socket connections
  // If not connected, return errors immediately rather than waiting for reconnect
  bufferMaxEntries: 0,
  connectTimeoutMS: 10000, // Give up initial connection after 10 seconds
  socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
  family: 4,
  useNewUrlParser: true
};


urlDataBase = "mongodb://admin:admin123@ds149806.mlab.com:49806/tests" // Set your Data Base URL here
//Production
mongoose.connect(urlDataBase, options)


const db = mongoose.connection
db.on('error', () => {
  console.log(db)
  throw new Error('unable to connect to database at ' + db)
})
