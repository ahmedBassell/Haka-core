module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :events, ::Types::EventType.connection_type, resolver: Resolvers::EventsResolver, null: false, description: "haka events"
    
    field :conversation, ::Types::ConversationType, resolver: Resolvers::ConversationResolver, null: false, description: "haka one conversation"
    field :conversations, ::Types::ConversationType.connection_type, resolver: Resolvers::ConversationsResolver, null: false, description: "haka conversations"
    
    field :current_user, ::Types::UserType, resolver: Resolvers::CurrentUserResolver, null: false, description: "current user"
  end
end
