(* Copyright (C) 2018  Petter A. Urkedal <paurkedal@gmail.com>
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version, with the OCaml static compilation exception.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this library.  If not, see <http://www.gnu.org/licenses/>.
 *)

(** ISO 639 - identification of natural languages and language groups

    This module provides a representation of languages covered by ISO 639-3 and
    ISO 639-5 and provides conversions to and from 2- and 3-letter codes defined
    in parts 1, 2, 3, and 5 of the standard.

    For common use cases part 3 of the standard, which covers individual
    languages, is a good choice.

    The functionality of this module is to large extent derived from:
    - ISO 639-2 data provided by https://www.loc.gov/standards/iso639-2/
    - ISO 639-3 data provided by http://www.iso639-3.sil.org/
    - ISO 639-5 data provided by https://www.loc.gov/standards/iso639-5/ *)

type t
(** This type represents an individual language or macrolanguage from ISO 639-3
    or a language group from ISO 639-5. *)

val equal : t -> t -> bool
(** [equal lang1 lang2] is true if [lang1] and [lang2] refer to the same
    individual, macro-, or collective language. *)

val compare : t -> t -> int
(** Total order corresponding to lexicographic order of codes within ISO 639-3
    and ISO 639-5.  {e The order of elements belonging to different parts of the
    standard is left unspecified} for now, and may change between versions until
    this notice is removed. *)

val to_int : t -> int
(** An injective mapping to 16 bit integers.  The result can be used for
    serialization, but note that {e the representation may change between
    versions} until this notice is removed.  An alternative for permanent storge
    or operability between versions, is to use {!to_part3} or {!to_part5} or
    both. *)

val of_int : int -> t option
(** [of_int] is the partial inverse of {!to_int}. *)

val of_int_exn : int -> t
(** [of_int_exn] is the partial inverse of {!to_int}.
    @raise Invalid_argument if the argument is out of range. *)

val is_part1 : t -> bool
(** [is_part1 lang] is true iff [lang] is represented in ISO 639-1. *)

val is_part2 : t -> bool
(** [is_part2 lang] is true iff [lang] is represented in ISO 639-2. *)

val is_part3 : t -> bool
(** [is_part3 lang] is true iff [lang] is an individual language, i.e. it is
    represented in ISO 639-3. *)

val is_part5 : t -> bool
(** [is_part3 lang] is true iff [lang] is a collective language, i.e. it is
    represented in ISO 639-5. *)

val to_part1_string : t -> string option
(** [to_part1_string lang] is the two-letter ISO 639-2 code for [lang] if it
    exists. *)

val to_part2t_string : t -> string option
(** [to_part3t_string lang] is the three-letter ISO 639-2T code for [lang]. *)

val to_part2b_string : t -> string option
(** [to_part3b_string lang] is the three-letter ISO 639-2B code for [lang]. *)

val to_part3_string : t -> string option
(** [to_part3_string lang] is the three-letter ISO 639-3 code for [lang].  The
    result coincides with the ISO 639-2 code if it exist, and may clash with an
    ISO 639-5 code for a language group. *)

val to_part5_string : t -> string option
(** [to_part5_string lang] is the three-letter ISO 639-5 code for [lang].  The
    result coincides with the ISO 639-2 code if it exist, and may clash with an
    ISO 639-3 code for an individual language or macrolanguage.  *)

val of_part1_string : string -> t option
val of_part2_string : string -> t option
val of_part3_string : string -> t option
val of_part5_string : string -> t option

val show : t -> string
(** [show lang] is a human readable representation of [lang] which may change
    across versions.

    Currently this function represents individual languages by their lower-cased
    ISO 639-3 codes and language families and groups by their upper-cased ISO
    639-5 codes.  Since this is somewhat ad-hoc, the representation may still
    change in a later version, if there is precedence for another convention.
    So, only use this for human readable output, otherwise use
    {!to_part3_string} or {!to_part5_string}. *)

val pp : Format.formatter -> t -> unit
(** [pp ppf lang] prints a human readable representation of [lang] on [ppf],
    using the same representation as {!show}. *)
