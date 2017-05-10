class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
      

    if user.role? :admin
        can :manage, :all
        
    elsif user.role? :manager
        #can read any info in system
        can :read, :all
        #can create, edit, read employee data
        can :create, User
        can :update, User 
        can :read, User
        #can  create, edit and read items in the system. 
       
        can :create, Item  
        can :update, Item 
        can :read, Item 

        # #can read full price history of particular item
        # can :read, Item do |this_price_history|
        #     this_price_history.item_prices.all 
        # end
        #can create new prices for a particular item
        can :create, ItemPrice  
        #can adjust the inventory levels for item by adding
        #purchases to the system
    

        #can view appropriate dashboard which includes a list of items
        #that need to be reordered

    elsif user.role? :shipper
        #read own personal info in system
        can :show, User do |u|
            u.id == user.id
        end
        #edit their own name, phone, email, password info
        can :update, User do |u|
            u.id ==user.id
        end
        #can read info related to orders that need to be shipped
        #from their home page, button to check off if shipped
        can :read, Order do |o|
            unshipped_orders = o.unshipped
        end
        #can read info about items on inventory lvl
        #but not price history
        can :read, Item 
    
    elsif user.role? :customer
        #can read own info in system
        can :show, User do |u|
            u.id == user.id
        end
        #can edit own info
        can :update, User do |u|
            u.id ==user.id
        end
        #can place new order
        #can cancel unshipped orders
        #can read info on item + imgs, not inv lvl or price hist
        can :read, Item @
        #can see list of own past orders
        #and itemized list of items of particular order
        can :show, Order do |this_order|
            my_orders = user.orders.map(&:id)
            my_orders.include? this_order.id
        end
    
    else #guests
        #can read info on items, not inv lvl or price history
        can :read, Item

        can :create, User
        can :create, School
    end
    
  end
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