class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
      

    if user.role? :admin
        can :manage, :all
        
    elsif user.role? :manager
        #can create, edit, read employee data
        can :create, User
        can :update, User 
        can :read, User
        #can  create, edit and read items in the system. This includes the power to
        #destroy or deactivate items as appropriate and the ability to upload
        #images of particular items.
        can :create, Item  
        can :update, Item 
        can :read, Item 

        #can read full price history of particular item
        can :index, Item do |i|
            i.item_prices.all 
        end
        #can create new prices for a particular item

        #can adjust the inventory levels for item by adding
        #purchases to the system

        #can view appropriate dashboard which includes a list of items
        #that need to be reordered

        #can read info about customers, schools, orders in system

    elsif user.role? :shipper
        #read own personal info in system
        #edit their own name, phone, email, password info



    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
