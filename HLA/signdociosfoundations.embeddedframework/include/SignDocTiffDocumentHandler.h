/* SignDocTiffDocumentHandler.h -*- C++ -*- */

#ifndef SP_SIGNDOCTIFFDOCUMENTHANDLER_H__
#define SP_SIGNDOCTIFFDOCUMENTHANDLER_H__

#if defined (_MSC_VER) && defined (SPSD_EXPORT)
#define SPSDEXPORT1 __declspec(dllexport)
#else
#define SPSDEXPORT1
#endif

/**
 * @brief SignDoc document handler for TIFF documents.
 *
 * This class is not available for architectures linux-arm,
 * ios-armv7, and ios-i386.
 */
class SignDocTiffDocumentHandler : public SignDocDocumentHandler
{
public:
  SPSDEXPORT1 SignDocTiffDocumentHandler ();
  virtual ~SignDocTiffDocumentHandler ();
  virtual SignDocDocument::DocumentType ping (de::softpro::spooc::InputStream &aStream);
  virtual SignDocDocument *loadFromMemory (const unsigned char *aData,
                                           size_t aSize,
                                           SPFontCache *aFontCache,
                                           SignDocDocument::DocumentType aType,
                                           std::string &aError);
  virtual SignDocDocument *loadFromFile (const wchar_t *aPath,
                                         bool aWritable,
                                         SPFontCache *aFontCache,
                                         SignDocDocument::DocumentType aType,
                                         std::string &aError);
};

#undef SPSDEXPORT1

#endif
