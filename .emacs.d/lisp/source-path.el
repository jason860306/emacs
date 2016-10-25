;;; source-path.el --- 

;; Copyright 2014 
;;
;; Author: szj0306@localhost.localdomain
;; Version: $Id: source-path.el,v 0.0 2014/08/28 07:04:00 szj0306 Exp $
;; Keywords: 
;; X-URL: not distributed yet

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

;;; Commentary:

;; 

;; Put this file into your load-path and the following into your ~/.emacs:
;;   (require 'source-path)

;;; Code:
(setq bfp2p-source-base-path (concatenate 'string "/home/szj0306/Documents/project"))
(setq bfp2p-source-server-path (concatenate 'string bfp2p-source-base-path "/bfp2p/p2psrv"))

;;; project base path(taishan, nasa etc)
(setq bfp2p-source-taishan-path (concatenate 'string bfp2p-source-server-path "/taishan/server"))
(setq bfp2p-source-nasa-path (concatenate 'string bfp2p-source-server-path "/nasa/server"))

;;; framecommon & srvframe
(setq bfp2p-source-framecommon-path (concatenate 'string bfp2p-source-taishan-path "/framecommon"))
(setq bfp2p-source-framecommon-include-path (concatenate 'string bfp2p-source-framecommon-path "/include"))
(setq bfp2p-source-framecommon-src-path (concatenate 'string bfp2p-source-framecommon-path "/src"))
(setq bfp2p-source-srvframe-path (concatenate 'string bfp2p-source-taishan-path "/srvframe"))
(setq bfp2p-source-srvframe-include-path (concatenate 'string bfp2p-source-srvframe-path "/include"))
(setq bfp2p-source-srvframe-src-path (concatenate 'string bfp2p-source-srvframe-path "/src"))

(defconst sys-head-file-dir    (list 
								;; system-head-file
								;; "E:/devtool/ctags/cpp_src"
								;; "D:/project/multimedia/ffmpeg/zeranoe/ffmpeg-win64-dev/include"
                               ))

(defconst sys-source-file-dir  (list
                               ))

(defconst user-head-file-dir   (list
								;; bfp2p-frame
								bfp2p-source-framecommon-include-path
								bfp2p-source-srvframe-include-path
								))

(defconst user-source-file-dir (list
								;; bfp2p-source
								bfp2p-source-framecommon-src-path
								(concatenate 'string bfp2p-source-srvframe-src-path "/command")
								(concatenate 'string bfp2p-source-srvframe-src-path "/common")
								(concatenate 'string bfp2p-source-srvframe-src-path "/main")
								(concatenate 'string bfp2p-source-srvframe-src-path "/task")
								(concatenate 'string bfp2p-source-srvframe-src-path "/thread")
								))

(defconst user-proj-file-dir (list))

(provide 'source-path)
(eval-when-compile
  (require 'cl))



;;;;##########################################################################
;;;;  User Options, Variables
;;;;##########################################################################





;;; source-path.el ends here
