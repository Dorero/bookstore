// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("@popperjs/core")
import('../src/CountPriceBook')
import('../src/ShowFullDescriptionBook')
import('../src/StarsRating')
import('../src/OneTableInOrder')
import('../src/CountPriceShipping')
import('../src/HintOnPayment')
import '@client-side-validations/simple-form/src'
import '@client-side-validations/client-side-validations/src'
import('bootstrap')
Rails.start()
Turbolinks.start()
ActiveStorage.start()
