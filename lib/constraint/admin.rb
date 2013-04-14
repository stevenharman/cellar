module Constraint
  class Admin

    def matches?(request)
      warden(request).authenticated? &&
      warden(request).user.admin?
    end

    private

    def warden(request)
      request.env['warden']
    end
  end
end
