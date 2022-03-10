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

(** ISO 639 - identification of natural languages and language groups

    The {!Lang} module is a good choice for common use cases where only
    individual languages and macrolanguages as covered by ISO 369-3 are needed.

    The functionality of this library is to large extent derived from:
    - ISO 639-2 data provided by {{:https://www.loc.gov/standards/iso639-2/}}
    - ISO 639-3 data provided by {{:http://www.iso639-3.sil.org/}}
    - ISO 639-5 data provided by {{:https://www.loc.gov/standards/iso639-5/}} *)

module Lang = Lang
module Lang_family = Lang_family
module Lang_or_family = Lang_or_family
