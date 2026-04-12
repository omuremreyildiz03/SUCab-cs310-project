import '../models/user.dart';

const UserProfile currentUser = UserProfile(
  name: 'Ulukan',
  suId: 'ulukan@sabanciuniv.edu',
  faculty: 'Engineering & Natural Sciences',
  year: '3rd Year',
  rating: 4.8,
  totalRides: 27,
  createdRides: 12,
  joinedRides: 15,
  bio: 'Regular commuter between Kadıköy and SU. I like a quiet ride and I\'m always on time!',
  avatarInitials: 'U',
);

const List<UserProfile> otherUsers = [
  UserProfile(
    name: 'Ece',
    suId: 'ece@sabanciuniv.edu',
    faculty: 'Engineering & Natural Sciences',
    year: '4th Year',
    rating: 4.9,
    totalRides: 44,
    createdRides: 30,
    joinedRides: 14,
    bio: 'I drive from Üsküdar every day. Happy to give rides to fellow SU students!',
    avatarInitials: 'E',
  ),
  UserProfile(
    name: 'Can',
    suId: 'can@sabanciuniv.edu',
    faculty: 'Management',
    year: '2nd Year',
    rating: 4.5,
    totalRides: 18,
    createdRides: 6,
    joinedRides: 12,
    bio: 'Looking for people to share rides with from Beşiktaş.',
    avatarInitials: 'C',
  ),
];
