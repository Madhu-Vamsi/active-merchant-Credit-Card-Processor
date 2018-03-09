require 'test_helper'

class RemoteAwesomesauceTest < Test::Unit::TestCase
  def setup
    @gateway = AwesomesauceGateway.new(fixtures(:awesomesauce))
    @amount = 100
    @credit_card = credit_card('4111111111111111')
    @options = {}
  end

<<<<<<< HEAD
  def test_successful_scrub
    t='getHTTPTranscripts()' 
    response = @gateway.scrub(t)
    assert_equal response, t
  end

=======
>>>>>>> Awesomesauce adapter scaffold
  def test_successful_purchase
    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response
  end

  def test_failed_purchase
    response = @gateway.purchase(101, @credit_card, @options)
    assert_failure response
    assert_equal "card_declined", response.message
  end

  def test_failed_capture
    response = @gateway.capture("")
    assert_equal "processing_error", response.message
  end

<<<<<<< HEAD
  def test_failed_authentication
    response = @gateway.authorize(101, @credit_card, @options)
    assert_failure response
    assert_equal "card_declined", response.message
  end

  def test_successful_authentication
    response = @gateway.authorize(100, @credit_card, @options)
    assert_success response
    assert_equal "1.00", response.params['amount']
  end

  def test_failed_refund
    response = @gateway.refund("", @options)
    assert_failure response
  end

  def test_successful_refund
    response = @gateway.purchase(100, @credit_card, @options)
    assert_success response
    response=@gateway.refund(response.params['id'],@options)
    assert_success response
  end

  def test_failed_void
    response = @gateway.void("", @options)
    assert_failure response
  end

  def test_successful_void
    response = @gateway.authorize(100, @credit_card, @options)
    assert_success response
    response=@gateway.void(response.params['id'],@options)
    assert_success response
  end

  def test_successful_capture
    response = @gateway.authorize(100, @credit_card, @options)
    assert_success response
    response=@gateway.capture(response.params['id'],@options)
    assert_success response
  end
=======
>>>>>>> Awesomesauce adapter scaffold
end
