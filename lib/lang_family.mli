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

(** Language families and groups as identified by ISO 639-5.

    ISO 639-5 defines language codes for selected language groups and families.
    A few of these are also present in ISO 639-1 and 639-2.  This module defines
    an abstract type covering these language families and groups, and provides
    conversions to the relevant language codes.

    Remainder groups of ISO 639-2 are not distinguished from the corresponding
    complete groups of ISO 639-5. *)

type t
(** A representation of language families and groups in ISO 639-5. *)

(** {2 Basic Operations} *)

val equal : t -> t -> bool
(** Equality of the corresponding ISO 693-5 language codes. *)

val compare : t -> t -> int
(** Lexicographic order of the corresponding ISO 639-5 language codes. *)

val pp : Format.formatter -> t -> unit
(** [pp ppf lang] prints the ISO 639-5 language code of [lang] on [ppf]. *)

(** {2 Conversions} *)

val to_int : t -> int
(** An injective mapping to 16 bit integers. *)

val of_int : int -> t option
(** The partial inverse of {!to_int}. *)

val of_int_exn : int -> t
(** The partial inverse of {!to_int}.
    @raise Invalid_argument if the argument is out of range. *)

val to_lang_or_family : t -> Lang_or_family.t
(** Injection into the combined ISO 639 type. *)

val of_lang_or_family : Lang_or_family.t -> t option
(** Restriction from the combined ISO 639 type. *)

(** {2 Language Code Conversions} *)

val to_string : t -> string
(** [to_string s] is the ISO 639-5 language code of [lang]. *)

val of_string : string -> t option
(** [of_string s] is the language family or group represented by the ISO 639-5
    code [s]. *)

val is_part1 : t -> bool
(** [is_part1 lang] is true iff [lang] is represented in ISO 639-1. *)

val to_part1_string : t -> string option
(** [to_part1_string lang] is the ISO 693-1 language code of [lang], if it
    exists. *)

val of_part1_string : string -> t option
(** [of_part1_string s] is the language represented by the ISO 639-1 language
    code [s]. *)

val is_part2 : t -> bool
(** [is_part2 lang] is true iff [lang] is represented in ISO 639-2. *)

val to_part2t_string : t -> string option
(** [to_part2t_string lang] is the ISO 639-2T language code of [lang], if it
    exists. *)

val to_part2b_string : t -> string option
(** [to_part2b_string lang] is the ISO 639-2B language code of [lang], if it
    exists. *)

val of_part2_string : string -> t option
(** [of_part2_string s] is the language represented by the ISO 639 part 2T or 2B
    language code [s]. *)
