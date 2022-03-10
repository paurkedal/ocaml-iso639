(* Copyright (C) 2018--2022  Petter A. Urkedal <paurkedal@gmail.com>
 *
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version, with the LGPL-3.0 Linking Exception.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * and the LGPL-3.0 Linking Exception along with this library.  If not, see
 * <http://www.gnu.org/licenses/> and <https://spdx.org>, respectively.
 *)

include Common

let of_int lang =
  if Data.is_iso639p5 lang then Some lang else None

let of_int_exn lang =
  if Data.is_iso639p5 lang then lang else
  invalid_arg "Iso639.Lang_family.of_int_exn"

let of_lang_or_family lang =
  let i = Lang_or_family.to_int lang in
  if i > 0x8000 then Some i else None

let to_lang_or_family = Lang_or_family.of_int_unsafe

let of_string = of_iso639p5

let of_string_exn s =
  (match of_iso639p5 s with
   | None -> invalid_arg "Iso639.Lang_family.of_string_exn"
   | Some lang -> lang)
