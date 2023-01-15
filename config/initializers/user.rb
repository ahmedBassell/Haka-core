# ROLE MAP
ROLE_MEMBER = T.let(:member, ::Symbol)
ROLE_OWNER = T.let(:owner, ::Symbol)

ROLE_MEMBER_ID = T.let(0, ::Integer)
ROLE_OWNER_ID = T.let(1, ::Integer)

ROLES_MAP = T.let(
  {
    ROLE_MEMBER => ROLE_MEMBER_ID,
    ROLE_OWNER => ROLE_OWNER_ID
  },
  T::Hash[::Symbol, ::Integer]
)

# GENDER MAP

GENDER_MALE = T.let(:male, ::Symbol)
GENDER_FEMALE = T.let(:female, ::Symbol)

GENDER_MALE_ID = T.let(0, ::Integer)
GENDER_FEMALE_ID = T.let(1, ::Integer)

GENDER_MAP = T.let(
  {
    GENDER_MALE => GENDER_MALE_ID,
    GENDER_FEMALE => GENDER_FEMALE_ID
  },
  T::Hash[::Symbol, ::Integer]
)