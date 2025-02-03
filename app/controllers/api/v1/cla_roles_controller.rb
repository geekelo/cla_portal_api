module API
  module V1
    class ClaRoles < ApplicationController
      def index
        roles = ClaRole.all
        render json: { roles: roles }, status: :ok
      end

      def show
        role = ClaRole.find(params[:id])
        render json: { role: role }, status: :ok
      end
      
      def create
        role = ClaRole.new(role_params)
        if role.save
          render json: { message: 'Role created successfully' }, status: :created
        else
          render json: { error: 'Something went wrong creating role' }, status: :unprocessable_entity
        end
      end

      def update      
        role = ClaRole.find(params[:id])
        if role.update(role_params)
          render json: { message: 'Role updated successfully' }, status: :ok
        else
          render json: { error: 'Something went wrong updating role' }, status: :unprocessable_entity
        end
      end

      def destroy
        role = ClaRole.find(params[:id])
        role.destroy
        render json: { message: 'Role deleted successfully' }, status: :ok
      end

      private

      def role_params
        params.require(:role).permit(:name)
      end
    end
  end
end
