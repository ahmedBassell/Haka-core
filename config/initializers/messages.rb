MESSAGE_TEXT_TYPE        = T.let(:text, Symbol)
MESSAGE_IMAGE_TYPE       = T.let(:image, Symbol)
MESSAGE_VIDEO_TYPE       = T.let(:video, Symbol)
MESSAGE_AUDIO_TYPE       = T.let(:audio, Symbol)
MESSAGE_DOCUMENT_TYPE    = T.let(:document, Symbol)
MESSAGE_WAITING_TYPE     = T.let(:waiting, Symbol)
MESSAGE_CONFIRMED_TYPE   = T.let(:confirmed, Symbol)

MESSAGE_TEXT_TYPE_ID      = T.let(0, ::Integer)
MESSAGE_IMAGE_TYPE_ID     = T.let(1, ::Integer)
MESSAGE_VIDEO_TYPE_ID     = T.let(2, ::Integer)
MESSAGE_AUDIO_TYPE_ID     = T.let(3, ::Integer)
MESSAGE_DOCUMENT_TYPE_ID  = T.let(4, ::Integer)
MESSAGE_WAITING_TYPE_ID   = T.let(5, ::Integer)
MESSAGE_CONFIRMED_TYPE_ID = T.let(6, ::Integer)

MESSAGE_TYPES_MAP = T.let(
  {
    MESSAGE_TEXT_TYPE      => MESSAGE_TEXT_TYPE_ID,
    MESSAGE_IMAGE_TYPE     => MESSAGE_IMAGE_TYPE_ID,
    MESSAGE_VIDEO_TYPE     => MESSAGE_VIDEO_TYPE_ID,
    MESSAGE_AUDIO_TYPE     => MESSAGE_AUDIO_TYPE_ID,
    MESSAGE_DOCUMENT_TYPE  => MESSAGE_DOCUMENT_TYPE_ID,
    MESSAGE_WAITING_TYPE   => MESSAGE_WAITING_TYPE_ID,
    MESSAGE_CONFIRMED_TYPE => MESSAGE_CONFIRMED_TYPE_ID
  },
  T::Hash[::Symbol, ::Integer]
)

MESSAGE_NO_SUBTYPE          = T.let(:no_subtype, Symbol)
MESSAGE_REPLIED_TO_SUBTYPE  = T.let(:replied_to, Symbol)
MESSAGE_FORWARDED_SUBTYPE   = T.let(:forwarded, Symbol)

MESSAGE_NO_SUBTYPE_ID         = T.let(0, ::Integer)
MESSAGE_REPLIED_TO_SUBTYPE_ID = T.let(1, ::Integer)
MESSAGE_FORWARDED_SUBTYPE_ID  = T.let(2, ::Integer)

MESSAGE_SUBTYPES_MAP = T.let(
  {
    MESSAGE_NO_SUBTYPE          => MESSAGE_NO_SUBTYPE_ID,
    MESSAGE_REPLIED_TO_SUBTYPE  => MESSAGE_REPLIED_TO_SUBTYPE_ID,
    MESSAGE_FORWARDED_SUBTYPE   => MESSAGE_FORWARDED_SUBTYPE_ID
  },
  T::Hash[::Symbol, ::Integer]
)

MESSAGE_ORIGIN_USER       = T.let(:user, Symbol)
MESSAGE_ORIGIN_SYSTEM     = T.let(:system, Symbol)

MESSAGE_ORIGIN_USER_ID    = T.let(0, ::Integer)
MESSAGE_ORIGIN_SYSTEM_ID  = T.let(1, ::Integer)

MESSAGE_ORIGIN_MAP = T.let(
  {
    MESSAGE_ORIGIN_USER   => MESSAGE_ORIGIN_USER_ID,
    MESSAGE_ORIGIN_SYSTEM => MESSAGE_ORIGIN_SYSTEM_ID
  },
  T::Hash[::Symbol, ::Integer]
)
