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

include Lang_or_family

let of_lang_or_family lang = if is_part3 lang then Some lang else None

let to_lang_or_family lang = lang

let of_int i = match of_int i with None -> None | Some lang -> of_lang_or_family lang

let of_int_exn i =
  let lang = of_int_exn i in
  if is_part3 lang then lang else failwith "Iso639.Lang.of_int_exn"

let of_string = of_part3_string

let to_string lang =
  (match to_part3_string lang with
   | Some s -> s
   | None -> assert false)

let scope lang = Data.lang3_scope (Lang_or_family.to_int lang)
