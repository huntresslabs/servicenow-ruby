module ServiceNow
  class ApiError < StandardError
    attr_reader :response, :message, :detail, :status

    def initialize(response)
      @response = response
      if response&.body
        @message = response.body.dig("error", "message")
        @detail = response.body.dig("error", "detail")
        @status = response.body["status"]
      end
    end
  end

  # HTTP 400
  class BadRequestError < ApiError; end

  # HTTP 401
  class UnauthorizedError < ApiError; end

  # HTTP 403
  class ForbiddenError < ApiError; end

  # HTTP 404
  class NotFoundError < ApiError; end

  # HTTP 405
  class MethodNotAllowedError < ApiError; end

  # HTTP 406
  class NotAcceptableError < ApiError; end

  # HTTP 415
  class UnsupportedMediaTypeError < ApiError; end
end