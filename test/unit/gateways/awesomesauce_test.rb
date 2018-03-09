require 'test_helper'

class AwesomesauceTest < Test::Unit::TestCase
  include CommStub

  def setup
    @gateway = AwesomesauceGateway.new(fixtures(:awesomesauce))
    @credit_card = credit_card
    @amount = 100
    @options = {}
  end

<<<<<<< HEAD
  def test_successful_scrub
    assert true
  end

  def test_successful_authorization
    @gateway.expects(:ssl_post).returns(successful_authorization_response)

    response = @gateway.authorize(@amount, @credit_card, @options)
    assert_success response

    assert_equal 'auth123', response.authorization
    assert response.test?
  end

  def test_failed_authorization
    @gateway.expects(:ssl_post).returns(failed_authorization_response)

    response = @gateway.authorize(@amount, @credit_card, @options)
    assert_failure response

    assert_equal 'authError', response.authorization
    assert response.test?
  end

  def test_failed_void
    @gateway.expects(:ssl_post).returns(failed_void_response)

    response = @gateway.void("", @options)
    assert_failure response

    assert_equal 'voidError123', response.authorization
    assert response.test?
  end

  def test_successful_void
    @gateway.expects(:ssl_post).returns(successful_authorization_response)

    response = @gateway.authorize(@amount, @credit_card, @options)
    assert_success response

    assert_equal 'auth123', response.authorization
    assert response.test?

    @gateway.expects(:ssl_post).returns(successful_void_response)
    response = @gateway.void(response.authorization, @options)
    assert_success response

    assert_equal 'voidSuccess123', response.authorization
    assert response.test?
  end

  def test_failed_refund
    @gateway.expects(:ssl_post).returns(failed_refund_response)

    response = @gateway.refund("",  @options)
    assert_failure response
  end

  def test_successful_refund
    @gateway.expects(:ssl_post).returns(successful_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response

    assert_equal 'purchcavE27m5', response.authorization
    assert response.test?

    @gateway.expects(:ssl_post).returns(successful_refund_response)
    response = @gateway.refund(response.authorization, @options)
    assert_success response

    assert_equal 'refundSuccess123', response.authorization
    assert response.test?
  end

=======
>>>>>>> Awesomesauce adapter scaffold
  def test_successful_purchase
    @gateway.expects(:ssl_post).returns(successful_purchase_response)

    response = @gateway.purchase(@amount, @credit_card, @options)
    assert_success response

    assert_equal 'purchcavE27m5', response.authorization
    assert response.test?
  end

  def test_failed_purchase
    @gateway.expects(:ssl_post).returns(failed_purchase_response)

    response = @gateway.purchase(101, @credit_card, @options)
    assert_failure response

    assert_equal Gateway::STANDARD_ERROR_CODE[:card_declined], response.message
  end

  def test_successful_capture
    @gateway.expects(:ssl_post).returns(successful_capture_response)

    response = @gateway.capture('autheP0VOTZn', @options)
    assert_success response

    assert_equal 'capok59rk45', response.authorization
    assert response.test?
  end

  def test_failed_capture
    @gateway.expects(:ssl_post).returns(failed_capture_response)

    response = @gateway.capture('', @options)
    assert_failure response

    assert_equal '10', response.error_code
    assert_equal Gateway::STANDARD_ERROR_CODE[:processing_error], response.message
  end

  private

  def pre_scrubbed
    <<-EOF
      opening connection to spreedly-gateway.herokuapp.com:443...
      opened
      starting SSL for spreedly-gateway.herokuapp.com:443...
      SSL established
      <- "POST /api/purchase.json HTTP/1.1\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nConnection: close\r\nHost: spreedly-gateway.herokuapp.com\r\nContent-Length: 290\r\n\r\n"
      <- "{\"amount\":100,\"currency\":\"USD\",\"number\":\"4000100011112224\",\"cv2\":\"123\",\"exp\":\"92018\",\"address\":{\"company\":\"Spreedly Inc\",\"address1\":\"1 Foster St.\",\"city\":\"Durham\",\"state\":\"NC\",\"country\":\"USA\",\"zip\":\"27701-3747\",\"phone\":\"1234567890\"},\"name\":\"Bobby Emmit\",\"merchant\":\"test\",\"secret\":\"abc123\"}"
      -> "HTTP/1.1 200 OK\r\n"
      -> "Connection: close\r\n"
      -> "Server: Cowboy\r\n"
      -> "Date: Wed, 12 Apr 2017 14:50:20 GMT\r\n"
      -> "Content-Length: 52\r\n"
      -> "Cache-Control: max-age=0, private, must-revalidate\r\n"
      -> "Content-Type: application/json; charset=utf-8\r\n"
      -> "Via: 1.1 vegur\r\n"
      -> "\r\n"
      reading 52 bytes...
      -> "{\"succeeded\":true,\"id\":\"purchcXvrWCv5\",\"amount\":100}"
      read 52 bytes
      Conn close
    EOF
  end

  def post_scrubbed
    <<-EOF
      opening connection to spreedly-gateway.herokuapp.com:443...
      opened
      starting SSL for spreedly-gateway.herokuapp.com:443...
      SSL established
      <- "POST /api/purchase.json HTTP/1.1\r\nContent-Type: application/x-www-form-urlencoded\r\nAccept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3\r\nAccept: */*\r\nUser-Agent: Ruby\r\nConnection: close\r\nHost: spreedly-gateway.herokuapp.com\r\nContent-Length: 290\r\n\r\n"
      <- "{\"amount\":100,\"currency\":\"USD\",\"number\":\"[FILTERED]\",\"cv2\":\"[FILTERED]\",\"exp\":\"92018\",\"address\":{\"company\":\"Spreedly Inc\",\"address1\":\"1 Foster St.\",\"city\":\"Durham\",\"state\":\"NC\",\"country\":\"USA\",\"zip\":\"27701-3747\",\"phone\":\"1234567890\"},\"name\":\"Bobby Emmit\",\"merchant\":\"test\",\"secret\":\"[FILTERED]\"}"
      -> "HTTP/1.1 200 OK\r\n"
      -> "Connection: close\r\n"
      -> "Server: Cowboy\r\n"
      -> "Date: Wed, 12 Apr 2017 14:50:20 GMT\r\n"
      -> "Content-Length: 52\r\n"
      -> "Cache-Control: max-age=0, private, must-revalidate\r\n"
      -> "Content-Type: application/json; charset=utf-8\r\n"
      -> "Via: 1.1 vegur\r\n"
      -> "\r\n"
      reading 52 bytes...
      -> "{\"succeeded\":true,\"id\":\"purchcXvrWCv5\",\"amount\":100}"
      read 52 bytes
      Conn close
    EOF
  end

  def successful_purchase_response
    %(
      {
        "succeeded": true,
        "id": "purchcavE27m5",
        "amount": "1.00"
      }
    )
  end

  def failed_purchase_response
    %q(
      {
        "succeeded": false,
        "id": "purcherr01tOl7CG4g",
        "error": "01"
      }
    )
  end

  def successful_capture_response
    %q(
      {
        "succeeded": true,
        "id": "capok59rk45"
      }
    )
  end

  def failed_capture_response
    %q(
      {
        "succeeded": false,
        "error": "10"
      }
    )
  end

  def successful_cancel_response
    %q(
      {
        "succeeded": true,
        "id": "canceldep6aus1"
      }
    )
  end

  def failed_cancel_response
    %q(
      {
        "succeeded": false,
        "error": "10"
      }
    )
  end
<<<<<<< HEAD

  def successful_authorization_response
    %(
      {
        "succeeded": true,
        "id": "auth123",
        "amount": "1.00"
      }
    )
  end

  def failed_authorization_response
    %q(
      {
        "succeeded": false,
        "id": "authError",
        "error": "01"
      }
    )
  end

  def failed_void_response
    %q(
      {
        "succeeded": false,
        "id": "voidError123",
        "error": "10"
      }
    )
  end

  def successful_void_response
    %q(
      {
        "succeeded": true,
        "id": "voidSuccess123"
      }
    )
  end

  def failed_refund_response
    %q(
      {
        "succeeded": false,
        "id": "refundError123",
        "error": "10"
      }
    )
  end

  def successful_refund_response
    %q(
      {
        "succeeded": true,
        "id": "refundSuccess123"
      }
    )
  end
=======
>>>>>>> Awesomesauce adapter scaffold
end
