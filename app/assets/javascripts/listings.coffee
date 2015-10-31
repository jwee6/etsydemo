# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
	payment.setupForm()

payment = 
	setupForm: ->
		$('#new_listing').submit ->
			if $('input').length > 6
				$('input[type=submit]').attr('disabled',true)
				Stripe.bankAccount.createToken($('#new_listing'), payment.handleStripeResponse)
				false

	handleStripeResponse: (status, response) ->
		if status == 200
			$('#new_listing').append($('<input type="hidden" name="stripeToken" />').val(response.id))
			$('#new_listing')[0].submit()
		else
			jQuery('#stripe_error').text(response.error.message).show()
			$('input[type=submit]').attr('disabled',false)

