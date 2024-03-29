# KAHA PROFILE POSITION
KAHA_PROFILE_POSITION_GENERAL = T.let(:general, ::Symbol)
KAHA_PROFILE_POSITION_DEFENDER = T.let(:defender, ::Symbol)
KAHA_PROFILE_POSITION_ATTACKER = T.let(:attacker, ::Symbol)
KAHA_PROFILE_POSITION_SPIKER = T.let(:spiker, ::Symbol)
KAHA_PROFILE_POSITION_MIDFIELDER = T.let(:midfielder, ::Symbol)

KAHA_PROFILE_POSITION_GENERAL_ID = T.let(0, ::Integer)
KAHA_PROFILE_POSITION_DEFENDER_ID = T.let(1, ::Integer)
KAHA_PROFILE_POSITION_ATTACKER_ID = T.let(2, ::Integer)
KAHA_PROFILE_POSITION_SPIKER_ID = T.let(3, ::Integer)
KAHA_PROFILE_POSITION_MIDFIELDER_ID = T.let(4, ::Integer)

KAHA_PROFILES_POSITIONS_MAP = T.let(
  {
    KAHA_PROFILE_POSITION_GENERAL => KAHA_PROFILE_POSITION_GENERAL_ID,
    KAHA_PROFILE_POSITION_DEFENDER => KAHA_PROFILE_POSITION_DEFENDER_ID,
    KAHA_PROFILE_POSITION_ATTACKER => KAHA_PROFILE_POSITION_ATTACKER_ID,
    KAHA_PROFILE_POSITION_SPIKER => KAHA_PROFILE_POSITION_SPIKER_ID,
    KAHA_PROFILE_POSITION_MIDFIELDER => KAHA_PROFILE_POSITION_MIDFIELDER_ID,
  },
  T::Hash[::Symbol, ::Integer]
)

# KAHA PROFILE RANK
KAHA_PROFILE_RANK_BEGINNER = T.let(:beginner, ::Symbol)
KAHA_PROFILE_RANK_MIDLEVEL = T.let(:midlevel, ::Symbol)
KAHA_PROFILE_RANK_PRO = T.let(:pro, ::Symbol)

KAHA_PROFILE_RANK_BEGINNER_ID = T.let(0, ::Integer)
KAHA_PROFILE_RANK_MIDLEVEL_ID = T.let(1, ::Integer)
KAHA_PROFILE_RANK_PRO_ID = T.let(2, ::Integer)

KAHA_PROFILE_RANKS_MAP = T.let(
  {
    KAHA_PROFILE_RANK_BEGINNER => KAHA_PROFILE_RANK_BEGINNER_ID,
    KAHA_PROFILE_RANK_MIDLEVEL => KAHA_PROFILE_RANK_MIDLEVEL_ID,
    KAHA_PROFILE_RANK_PRO => KAHA_PROFILE_RANK_PRO_ID
  },
  T::Hash[::Symbol, ::Integer]
)

# KAHA PROFILE PRIORITY
KAHA_PROFILE_PRIORITY_LOW = T.let(:priority_low, ::Symbol)
KAHA_PROFILE_PRIORITY_NORMAL = T.let(:priority_normal, ::Symbol)
KAHA_PROFILE_PRIORITY_HIGH = T.let(:priority_high, ::Symbol)

KAHA_PROFILE_PRIORITY_LOW_ID = T.let(0, ::Integer)
KAHA_PROFILE_PRIORITY_NORMAL_ID = T.let(1, ::Integer)
KAHA_PROFILE_PRIORITY_HIGH_ID = T.let(2, ::Integer)

KAHA_PROFILES_PRIORITY_MAP = T.let(
  {
    KAHA_PROFILE_PRIORITY_LOW => KAHA_PROFILE_PRIORITY_LOW_ID,
    KAHA_PROFILE_PRIORITY_NORMAL => KAHA_PROFILE_PRIORITY_NORMAL_ID,
    KAHA_PROFILE_PRIORITY_HIGH => KAHA_PROFILE_PRIORITY_HIGH_ID
  },
  T::Hash[::Symbol, ::Integer]
)

# KAHA PROFILE BOOKING
KAHA_PROFILE_BOOKING_MANUAL = T.let(:booking_manual, ::Symbol)
KAHA_PROFILE_BOOKING_WEEKLY = T.let(:booking_weekly, ::Symbol)
KAHA_PROFILE_BOOKING_BIWEEKLY = T.let(:booking_biweekly, ::Symbol)

KAHA_PROFILE_BOOKING_MANUAL_ID = T.let(0, ::Integer)
KAHA_PROFILE_BOOKING_WEEKLY_ID = T.let(1, ::Integer)
KAHA_PROFILE_BOOKING_BIWEEKLY_ID = T.let(2, ::Integer)

KAHA_PROFILES_BOOKING_MAP = T.let(
  {
    KAHA_PROFILE_BOOKING_MANUAL => KAHA_PROFILE_BOOKING_MANUAL_ID,
    KAHA_PROFILE_BOOKING_WEEKLY => KAHA_PROFILE_BOOKING_WEEKLY_ID,
    KAHA_PROFILE_BOOKING_BIWEEKLY => KAHA_PROFILE_BOOKING_BIWEEKLY_ID
  },
  T::Hash[::Symbol, ::Integer]
)