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

type t = int
let equal = (=)
let compare = compare
let to_int x = x

let is_valid lang =
  Char.code (Data.is_iso639p3_bits.[lang / 8]) lsr (lang mod 8) land 1 = 1

let of_int lang = if is_valid lang then Some lang else None

let of_int_exn lang =
  if is_valid lang then lang else invalid_arg "Iso639.of_int_exn"

let is_part1 x = Data.to_iso639p1 x <> x
let is_part2 x = Data.is_iso639p2t x
let is_part3 x = x < 0x8000
let is_part5 x = x > 0x8000

let alpha_of_int x = Char.chr (x mod 32 + 0x60)

let int_of_alpha = function
 | 'a'..'z' as c -> Char.code c - 0x60
 | _ -> raise Not_found

let to_alpha2 x = String.init 2 (fun i -> alpha_of_int (x lsr (5 * (1 - i))))
let to_alpha3 x = String.init 3 (fun i -> alpha_of_int (x lsr (5 * (2 - i))))

let to_part1_string lang =
  let lang1 = Data.to_iso639p1 lang in
  if lang1 = lang then None else Some (to_alpha2 lang1)

let to_part2t_string lang =
  if Data.is_iso639p2t lang then Some (to_alpha3 lang) else None

let to_part2b_string lang =
  if Data.is_iso639p2t lang
  then Some (to_alpha3 (Data.to_iso639p2b lang)) else None

let to_part3_string lang =
  if is_part3 lang then Some (to_alpha3 lang) else None

let to_part5_string lang =
  if is_part5 lang then Some (to_alpha3 lang) else None

let of_part1_string s =
  if String.length s <> 2 then None else
  try
    let lang1 = int_of_alpha s.[0] lsl 5 + int_of_alpha s.[1] in
    let lang3 = Data.of_iso639p1 lang1 in
    if lang1 = lang3 then None else Some lang3
  with Not_found -> None

let int_of_alpha3 s =
  if String.length s <> 3 then raise Not_found else
  int_of_alpha s.[0] lsl 10 + int_of_alpha s.[1] lsl 5 + int_of_alpha s.[2]

let of_part2_string s =
  try
    let lang = Data.of_iso639p2b (int_of_alpha3 s) in
    let lang3 = lang land 0x8000 in
    if Data.is_iso639p2t lang3 then Some lang3 else
    if Data.is_iso639p2t lang then Some lang else
    None
  with Not_found -> None

let of_part3_string s =
  try
    let lang = int_of_alpha3 s in
    if is_valid lang then Some lang else None
  with Not_found -> None

let of_part5_string s =
  try
    let lang = int_of_alpha3 s lor 0x8000 in
    if Data.is_iso639p5 lang then Some lang else
    None
  with Not_found -> None

let show lang =
  let s = to_alpha3 lang in
  if is_part3 lang then s else String.uppercase_ascii s

let pp ppf lang = Format.pp_print_string ppf (show lang)

let scope x = if is_part3 x then Data.lang3_scope x else `Collective
