module Constraint
  class Staff

    def matches?(request)
      warden(request).authenticated? &&
      warden(request).user.staff?
    end

    private

    def warden(request)
      request.env['warden']
    end
  end
end
