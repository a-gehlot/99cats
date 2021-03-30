class CatRentalRequestsController < ApplicationController
    def new
        @request = CatRentalRequest.new
        render :new
    end

    def create
        @request = CatRentalRequest.new(request_params)
        if @request.save
            redirect_to cat_url(@request.cat)
        else
            render :new
        end
    end

    def approve
        @request = CatRentalRequest.find_by(id: params[:id])
        @request.approve!
        redirect_to cat_url(@request.cat)
    end

    def deny
        @request = CatRentalRequest.find_by(id: params[:id])
        @request.deny!
        redirect_to cat_url(@request.cat)
    end

    private

    def request_params
        params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
    end
end