//= require i18n
//= require i18n.js
//= require i18n/translations
//= require jquery3
//= require popper
//= require bootstrap-sprockets

import Rails from "@rails/ujs"

import Turbolinks from "turbolinks"

import * as ActiveStorage from "@rails/activestorage"

import "channels"

import 'bootstrap'

Rails.start()

Turbolinks.start()


ActiveStorage.start()
