# regex taken from backbone - used to split event for delegation
delegateEventSplitter = /^(\S+)\s*(.*)$/

class Plugin

  # specific to upthere
  attributes:
    isDraggable: yes
    isDownloadable: yes
    isShareable: yes
    isDeletable: yes

  # initialize a previewplugin with a type
  constructor: (type, el_data) ->
    @type = type
    # bind all defined events to their selectors with given method
    _.each @_events, (method, key) ->
      match = key.match delegateEventSplitter
      [eventName, selector] = match
      if not selector
        @$el.on eventName, method
      else
        @$el.on eventName, selector, method
    @el = _.template @template, el_data

  # template
  # el
  # $el

  # template: ->
  #   throw new Error('No template defined.')

  # initialization code for the view
  init: ->

  # mild/mostly useless error checking. TODO: probably want to take it out
  _events: ->
    if not @events typeof Object
      throw new Error('events is not an object')
    else @events

  # binding events (click, keypress, etc)
  # format:
  # "event selector": "method name"
  events: {}
  get: (attr) ->
    @attributes[attr]
  set: (attr, val) ->
    @attributes[attr] = val
    # TODO: re-render the template, implement pub/sub or use airwaves.
    @render()

  # update is called by the event delegator from the controller.
  # in the event that this view needs to be changed, update passes a data object with the necessary information as its first parameter
  update: (data) ->
    throw new Error('update is an abstract method')

  # By default returns $el
  render: ->
    $el


exports = upthere.preview = {}

##
# controller - delegates events to views and renders them
# attaches to an existing dom element as context
##
#
# want to be able to make views replaceable - top view

class Controller
  plugins:
    active: []
    inactive: []

  # creates a named instance. For example, "preview" controller
  constructor: (type, selector) ->
    @type = type
    @$el = $(selector)
    @el = @$el[0]
    @init()

  # takes in zero or more arguments
  addPlugins: ->
    args = Array.prototype.slice.call(arguments, 0)
    for plugin in args
      @plugins.inactive.push plugin

  activate: ->

  # initialization code for the controller
  init: ->

  # Events mapped to functions
  # for example, "selection"
  events: {}

