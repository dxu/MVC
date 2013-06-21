delegateEventSplitter = /^(\S+)\s*(.*)$/

class Plugin
  # taken from backbone - used to split event for delegation

  attributes:
    isDraggable: yes
    isDownloadable: yes
    isShareable: yes
    isDeletable: yes


  # initialize a previewplugin with a type
  constructor: (type) ->
    @type = type
    # bind all defined events to

  # template
  # el
  # $el

  # template: ->
  #   throw new Error('No template defined.')

  # initialization code for the view
  init: ->

  _events: ->
    if not events typeof Object
      throw new Error('events is not an object')
    else events

  # binding events (click, keypress, etc)
  # format:
  # "event selector": "method name"
  events: {}


  get: (attr) ->
    @attributes[attr]
  set: (attr, val) ->
    @attributes[attr] = val
    # TODO: re-render the template
    @render()

  update: () ->
    throw new Error('Initialize is an abstract method')

  # By default returns rendered template
  render: ->
    _.template @template

  # Override to return `no` if  this preview type is *not* deletable.
  # (The default is to be deletable.)

plugins = {}
exports = upthere.preview = {}

##
# controller - delegates events to views and renders them
# attaches to an existing dom element as context
#
##

class Controller


  # creates a type. For example, "preview" controller
  constructor: (type, selector) ->
    @type = type
    @$el = $(selector)
    @el = @$el[0]
    @init()

  # initialization code for the controller
  init: ->

  # Events mapped to functions
  # for this case, "selection"
  events: {}





