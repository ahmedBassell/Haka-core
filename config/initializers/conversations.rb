CONVERSATION_ONE_ON_ONE_TYPE  = T.let(:one_on_one, Symbol)
CONVERSATION_EVENT_GROUP_TYPE = T.let(:event, Symbol)
CONVERSATION_BROADCAST_TYPE   = T.let(:broadcast, Symbol)

CONVERSATION_ONE_ON_ONE_TYPE_ID   = T.let(0, ::Integer)
CONVERSATION_EVENT_GROUP_TYPE_ID  = T.let(1, ::Integer)
CONVERSATION_BROADCAST_TYPE_ID    = T.let(2, ::Integer)

CONVERSATION_TYPES_MAP = T.let(
  {
    CONVERSATION_ONE_ON_ONE_TYPE  => CONVERSATION_ONE_ON_ONE_TYPE_ID,
    CONVERSATION_EVENT_GROUP_TYPE => CONVERSATION_EVENT_GROUP_TYPE_ID,
    CONVERSATION_BROADCAST_TYPE   => CONVERSATION_BROADCAST_TYPE_ID
  },
  T::Hash[::Symbol, ::Integer]
)