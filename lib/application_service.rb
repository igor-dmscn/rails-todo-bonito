class ApplicationService

  def self.call(**args)
    new(**args).call
  end

  class Result
    attr_reader :data

    def initialize(success:, data: nil)
      @success = success
      @data = data
    end

    def success?
      @success
    end

    def failure?
      !success?
    end

    private
    attr_reader :success
  end

  class SuccessResult < Result
    def initialize(data: nil)
      super(success: true, data:)
    end
  end

  class FailureResult < Result
    def initialize(data: nil)
      super(success: false, data:)
    end
  end
end
