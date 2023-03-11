MESSAGE_TEXT_TYPE        = T.let(:text, Symbol)
MESSAGE_IMAGE_TYPE       = T.let(:image, Symbol)
MESSAGE_VIDEO_TYPE       = T.let(:video, Symbol)
MESSAGE_AUDIO_TYPE       = T.let(:audio, Symbol)
MESSAGE_DOCUMENT_TYPE    = T.let(:document, Symbol)

MESSAGE_TEXT_TYPE_ID      = T.let(0, ::Integer)
MESSAGE_IMAGE_TYPE_ID     = T.let(1, ::Integer)
MESSAGE_VIDEO_TYPE_ID     = T.let(2, ::Integer)
MESSAGE_AUDIO_TYPE_ID     = T.let(3, ::Integer)
MESSAGE_DOCUMENT_TYPE_ID  = T.let(4, ::Integer)

MESSAGE_TYPES_MAP = T.let(
  {
    MESSAGE_TEXT_TYPE     => MESSAGE_TEXT_TYPE_ID,
    MESSAGE_IMAGE_TYPE    => MESSAGE_IMAGE_TYPE_ID,
    MESSAGE_VIDEO_TYPE    => MESSAGE_VIDEO_TYPE_ID,
    MESSAGE_AUDIO_TYPE    => MESSAGE_AUDIO_TYPE_ID,
    MESSAGE_DOCUMENT_TYPE => MESSAGE_DOCUMENT_TYPE_ID
  },
  T::Hash[::Symbol, ::Integer]
)

MESSAGE_NO_SUBTYPE          = T.let(:no_subtype, Symbol)
MESSAGE_REPLIED_TO_SUBTYPE  = T.let(:replied_to, Symbol)
MESSAGE_FORWARDED_SUBTYPE   = T.let(:forwarded, Symbol)

MESSAGE_NO_SUBTYPE_ID         = T.let(0, ::Integer)
MESSAGE_REPLIED_TO_SUBTYPE_ID = T.let(1, ::Integer)
MESSAGE_FORWARDED_SUBTYPE_ID  = T.let(2, ::Integer)

MESSAGE_TYPES_MAP = T.let(
  {
    MESSAGE_NO_SUBTYPE          => MESSAGE_NO_SUBTYPE_ID,
    MESSAGE_REPLIED_TO_SUBTYPE  => MESSAGE_REPLIED_TO_SUBTYPE_ID,
    MESSAGE_FORWARDED_SUBTYPE   => MESSAGE_FORWARDED_SUBTYPE_ID
  },
  T::Hash[::Symbol, ::Integer]
)