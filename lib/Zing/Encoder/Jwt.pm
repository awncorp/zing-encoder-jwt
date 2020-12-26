package Zing::Encoder::Jwt;

use 5.014;

use strict;
use warnings;

use registry 'Zing::Types';
use routines;

use Data::Object::Class;
use Data::Object::ClassHas;

extends 'Zing::Encoder';

use Crypt::JWT ();

# VERSION

# ATTRIBUTES

has algo => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_algo($self) {
  $ENV{ZING_JWT_ALGO} || 'HS256'
}

has secret => (
  is => 'ro',
  isa => 'Str',
  new => 1,
);

fun new_secret($self) {
  $ENV{ZING_JWT_SECRET}
}

# METHODS

method decode(Str $data) {
  return Crypt::JWT::decode_jwt(
    key => $self->secret,
    token => $data,
  );
}

method encode(HashRef $data) {
  return Crypt::JWT::encode_jwt(
    alg => $self->algo,
    key => $self->secret,
    payload => $data,
  );
}

1;
