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

(** Individual languages and macrolanguages as identified by ISO 639-3.

    This module represents all languages which have a language code in ISO
    639-3.  It provides and provides string conversions to and from language
    codes defined in ISO 639-1, ISO 639-2, and ISO 639-3, where the former two
    are only partially covered. *)

type t
(** A representation of languages present in ISO 639-3. *)

val equal : t -> t -> bool
(** Equality of the corresponding ISO 639-3 language codes. *)

val compare : t -> t -> int
(** Lexicographic order of the corresponding ISO 639-3 language codes. *)

val to_int : t -> int
(** An injective mapping to 16 bit integers. *)

val of_int : int -> t option
(** The partial inverse of {!to_int}. *)

val of_int_exn : int -> t
(** The partial inverse of {!to_int}.
    @raise Invalid_argument if the argument is out of range. *)

val of_lang_or_family : Lang_or_family.t -> t option
(** Restriction from the combined ISO 639 type. *)

val to_lang_or_family : t -> Lang_or_family.t
(** Injection into the combined ISO 639 type. *)

val of_string : string -> t option
(** [of_string s] is the language represented by the ISO 639-3 language code
    [s]. *)

val to_string : t -> string
(** [to_string lang] is the ISO 639-3 language code of [lang]. *)

val of_part1_string : string -> t option
(** [of_part1_string s] is the language represented by the ISO 639-1 language
    code [s]. *)

val to_part1_string : t -> string option
(** [to_part1_string lang] is the ISO 693-1 language code of [lang], if it
    exists. *)

val of_part2_string : string -> t option
(** [of_part2_string s] is the language represented by the ISO 639 part 2T or 2B
    language code [s]. *)

val to_part2t_string : t -> string option
(** [to_part2t_string lang] is the ISO 639-2T language code of [lang], if it
    exists. *)

val to_part2b_string : t -> string option
(** [to_part2b_string lang] is the ISO 639-2B language code of [lang], if it
    exists. *)

val scope : t -> [> `Individual | `Macro | `Special]
(** [scope lang] is [`Individual] if [lang] is an individual language [`Macro]
    if [lang] is a macrolanguage, or [`Special] if [lang] is not a language. *)
