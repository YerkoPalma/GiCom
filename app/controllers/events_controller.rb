class EventsController < ApplicationController

	def create
		@event = Event.new(event_params)
		if @event.save
			redirect_to event_path @event
		else
			redirect_to root_url
		end
	end

	def show
		@event = Event.find(params[:id])
	end

	private

    def event_params
      params.require(:event).permit(:expositor, :lugar, :fecha,
                                   :categoria, :cliente)
    end
end
