/* SignDocPdfDocumentHandler.h -*- C++ -*- */

#ifndef SP_SIGNDOCPDFDOCUMENTHANDLER_H__
#define SP_SIGNDOCPDFDOCUMENTHANDLER_H__

#if defined (_MSC_VER) && defined (SPSD_EXPORT)
#define SPSDEXPORT1 __declspec(dllexport)
#else
#define SPSDEXPORT1
#endif

/**
 * @brief SignDoc document handler for PDF documents.
 *
 * This class is not available for architecture linux-arm.
 */
class SignDocPdfDocumentHandler : public SignDocDocumentHandler
{
public:
  SPSDEXPORT1 SignDocPdfDocumentHandler ();
  virtual ~SignDocPdfDocumentHandler ();
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
