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

(** Language families and groups as identified by ISO 639-5. *)

type t

val equal : t -> t -> bool

val compare : t -> t -> int

val to_int : t -> int

val of_int : int -> t option

val of_int_exn : int -> t

val of_lang_or_family : Lang_or_family.t -> t option

val to_lang_or_family : t -> Lang_or_family.t

val of_string : string -> t option

val to_string : t -> string

val of_part1_string : string -> t option

val of_part2_string : string -> t option

val to_part2t_string : t -> string option

val to_part2b_string : t -> string option
