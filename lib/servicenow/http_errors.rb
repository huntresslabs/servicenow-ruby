module ServiceNow
  class HttpErrors < Faraday::Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 400
        raise BadRequestError, env.response
      when 401
        raise UnauthorizedError, env.response
      when 403
        raise ForbiddenError, env.response
      when 404
        raise NotFoundError, env.response
      when 405
        raise MethodNotAllowedError, env.response
      when 406
        raise NotAcceptableError, env.response
      when 415
        raise UnsupportedMediaTypeError, env.response
      when 500..600
        raise ApiError, env.response
      end
    end
  end
end