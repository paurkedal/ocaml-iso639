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

open Iso639
open Printf

let check_lang lang =
  assert (Lang.equal (Lang.of_int_exn (Lang.to_int lang)) lang);
  (match Lang.of_string (Lang.to_string lang) with
   | None -> assert false
   | Some lang' -> assert (Lang.equal lang lang'))

let check_lang_family lang =
  assert (Lang_family.equal (Lang_family.of_int_exn (Lang_family.to_int lang))
                            lang)

let check_alpha2 p1_count alpha2 =
  (match Lang_or_family.of_part1_string alpha2 with
   | Some lang ->
      incr p1_count;
      assert (Lang_or_family.to_part1_string lang = Some alpha2)
   | None -> ())

let check_alpha3 p2_count p3_count p5_count alpha3 =
  let langI = Lang.of_string alpha3 in
  let lang3 = Lang_or_family.of_part3_string alpha3 in
  let langF = Lang_family.of_string alpha3 in
  let lang5 = Lang_or_family.of_part5_string alpha3 in
  (match langI, lang3, langF, lang5 with
   | None, None, None ,None -> ()
   | Some langI, Some lang3, None, None ->
      incr p3_count;
      assert (Lang_or_family.to_part3_string lang3 = Some alpha3);
      assert (Lang_or_family.scope lang3 <> `Collective);
      assert (Lang_or_family.equal (Lang.to_lang_or_family langI) lang3);
      check_lang langI
   | None, None, Some langF, Some lang5 ->
      incr p5_count;
      assert (Lang_or_family.to_part5_string lang5 = Some alpha3);
      assert (Lang_or_family.scope lang5 = `Collective);
      assert (Lang_or_family.equal (Lang_family.to_lang_or_family langF) lang5);
      check_lang_family langF
   | _ -> assert false);
  (match Lang_or_family.of_part2_string alpha3 with
   | Some lang2 ->
      let alpha_p2t = Lang_or_family.to_part2t_string lang2 in
      let alpha_p2b = Lang_or_family.to_part2b_string lang2 in
      let is_bib =
        (match alpha_p2t, alpha_p2b with
         | None, None -> assert false
         | None, Some _ | Some _, None -> assert false
         | Some p2t, Some p2b ->
            incr p2_count;
            assert (p2t = alpha3 || p2b = alpha3);
            alpha3 <> p2t) in
      (match lang3, lang5 with
       | None, None -> assert is_bib
       | Some langI, None -> assert (Lang_or_family.equal lang2 langI)
       | None, Some langF -> assert (Lang_or_family.equal lang2 langF)
       | Some langI, Some langF ->
          assert (not (Lang_or_family.equal langI langF)))
   | None -> ())

let check_scope () =
  let chk langI scope =
    let lang =
      (match Lang_or_family.of_part3_string langI with
       | Some lang -> lang
       | None -> assert false) in
    assert (Lang_or_family.scope lang = scope) in
  chk "spa" `Individual;
  chk "nor" `Macro;
  chk "mis" `Special

let () =
  let p1_count = ref 0 in
  let p2_count = ref 0 in
  let p3_count = ref 0 in
  let p5_count = ref 0 in
  for i0 = 0 to 255 do
    let ch0 = Char.chr i0 in
    for i1 = 0 to 255 do
      let ch1 = Char.chr i1 in
      let alpha2 = sprintf "%c%c" ch0 ch1 in
      check_alpha2 p1_count alpha2;
      for i2 = 0 to 255 do
        let ch2 = Char.chr i2 in
        let alpha3 = sprintf "%c%c%c" ch0 ch1 ch2 in
        check_alpha3 p2_count p3_count p5_count alpha3
      done
    done
  done;
  check_scope ()
