# regex taken from backbone - used to split event for delegation
delegateEventSplitter = /^(\S+)\s*(.*)$/

class Plugin
  # TODO: need a way to re-render the tempaltes. one option is backbone views
  # other option: custom data attribute for each "attributes", set value of that data type
  #
  # #TODO: custom templating language that adds data attributes to html. choose which ones to re render

  # all mutable attributes
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
  set: (attr, val, regen=true) ->
    @attributes[attr] = val
    # TODO: re-render the template, implement pub/sub or use airwaves.
    if regen
      @render()

  # update is called by the event delegator from the controller.
  # in the event that this view needs to be changed, update passes a data object with the necessary information as its first parameter
  update: (data) ->
    throw new Error('update is an abstract method')

  # render replaces data attributes that get changed
  render: ->



exports = upthere.preview = {}

##
# controller - delegates events to views and renders them
# attaches to an existing dom element as context
##
#
# want to be able to make views replaceable - top view

# specific to upthere: plugins are unique by type
class Controller

  plugins: {}
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
      @plugins[plugin.type] = plugin

  # search by function, object literal, or default type
  search: (criteria) ->
    if criteria instanceof Function
      return _.filter(@plugins, criteria)
    else if criteria.constructor == Object and typeof criteria == 'object'
      return _.where(@plugins, criteria)
    # otherwise just the string type
    else @plugin[criteria]

  # method to replace one plugin with another
  replacePlugin: (criteria1, critera2) ->
    @search(criteria1).$el.replaceWith @search(criteria2).$el

  # initialization code for the controller
  init: ->

  # Events mapped to functions
  # for example, "selection"
  events: {}

