versionCheck = (scope)->
  scope.alert ||= false
  scope.requiredProtocolVerion ||= 6
  scope.disconnect ||= true

  if (typeof Leap != 'undefined') && Leap.Controller
    if Leap.version.minor < 5 && Leap.version.dot < 4
      console.warn("LeapJS Version Check plugin incompatible with LeapJS pre 0.4.4")


  @on 'ready', ->
    required = scope.requiredProtocolVerion
    current = @connection.opts.requestProtocolVersion

    if current < required
      console.warn "Protocol Version too old. v#{required} required, v#{current} available."

      if scope.disconnect
        @disconnect()

      if scope.alert
        alert("Your Leap Software version is out of date.  Visit http://www.leapmotion.com/setup to update")

      @emit('versionCheck.outdated', {
        required: required
        current: current
        disconnect: scope.disconnect
      })

  {}
  
  
if (typeof Leap != 'undefined') && Leap.Controller
  Leap.Controller.plugin 'versionCheck', versionCheck
else if (typeof module != 'undefined')
  module.exports.versionCheck = versionCheck
else
  throw 'leap.js not included'  